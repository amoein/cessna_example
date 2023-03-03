%%%-------------------------------------------------------------------
%% @doc cessna_example public API
%% @end
%%%-------------------------------------------------------------------

-module(cessna_example_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-include_lib("cessna/include/cessna.hrl").

%%====================================================================
%% API
%%====================================================================
start(_StartType, _StartArgs) ->
    application:ensure_started(cessna),
    IPS = application:get_env(cessna_example, ips, [{0, 0, 0, 0}]),
    WorkersCount = application:get_env(cessna_example, workers, 100),
    Option =
        #option{
            type = tcp,
            port = 5050,
            handler_module = cessna_example_socket,
            handler_func = start_link,
            number_of_worker = WorkersCount,
            notify_pool_per_accept = 10,
            ips = IPS,
            socket_option = [binary, {keepalive, false}, {reuseaddr, true}]
        },

    {ok, _} = cessna_sup:add_new_pool(test1, Option),

    cessna_example_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.
