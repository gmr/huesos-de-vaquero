-module(huesos_http).

-behaviour(gen_server).

-export([start_link/0,
         init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-define(ACCEPTORS,  100).

-include("huesos_status_codes.hrl").

-record(state, {}).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).



%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init([]) ->
    Dispatch = cowboy_router:compile(routes()),
    cowboy:start_http(huesos_listener,
                      ?ACCEPTORS,
                      [{port, port()}],
                      [{env, [{dispatch, Dispatch}]},
                       {onresponse, fun error_hook/4}]),
    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {noreply, State}.

handle_cast(_Request, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    cowboy:stop_listener(huesos_listener).

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Hijack outbound responses to provide error pages
%% ------------------------------------------------------------------

error_hook(Code, _Headers, _Body, Req) when is_integer(Code), Code >= 400 ->
  Message = proplists:get_value(Code, ?STATUS_CODES, <<"Undefined Error Code">>),

  {ok, Body} = error_page_dtl:render([{code, integer_to_list(Code)},
                                      {message, Message}]),
  Headers = [{<<"Content-Type">>, <<"text/html">>}],
  {ok, Req2} = cowboy_req:reply(Code, Headers, Body, Req),
  Req2;

error_hook(_Code, _Headers, _Body, Req) ->
	Req.

%% ------------------------------------------------------------------
%% Private Function Definitions
%% ------------------------------------------------------------------

routes() ->
  %% {URIHost, list({URIPath, Handler, Opts})}
  [
    {'_', [
      {"/",                huesos_home,      []},
      {"/styleguide.html", huesos_styleguide, []},
      {"/images/[...]",    cowboy_static, {dir, [<<"static/images">>]}},
      {"/fonts/[...]",     cowboy_static, {dir, [<<"static/fonts">>]}},
      {"/static/[...]",    cowboy_static, {dir, [<<"static">>]}},
      {"/scripts/[...]",   cowboy_static, {dir, [<<"static/scripts">>]}},
      {"/styles/[...]",    cowboy_static, {dir, [<<"static/styles">>]}}
    ]}
  ].

port() ->
  case os:getenv("PORT") of
    false ->
      {ok, Port} = application:get_env(http_port),
      Port;
    Other ->
      list_to_integer(Other)
  end.
