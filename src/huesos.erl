%% ------------------------------------------------------------------
%% Module used for running the development version of the app only
%% ------------------------------------------------------------------

-module(huesos).

-export([start/0]).

-define(APPS, [crypto, ranch, cowlib, cowboy, compiler, syntax_tools, erlydtl, huesos]).

start() ->
  start_apps(?APPS).

start_apps([]) -> ok;
start_apps([App | Apps]) ->
  case application:start(App) of
    ok -> start_apps(Apps);
    {error, {already_started, App}} -> start_apps(Apps)
  end.
