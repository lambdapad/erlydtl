-module(erlydtl_runtime_tests).

-include_lib("eunit/include/eunit.hrl").

capture_exit_returns_the_value_on_success_test() ->
    ?assertEqual(ok, erlydtl_runtime:capture_exit(fun() -> ok end)).

capture_exit_passes_a_thrown_value_through_unchanged_test() ->
    ?assertEqual(
       {error, boom},
       erlydtl_runtime:capture_exit(fun() -> throw({error, boom}) end)
      ).

capture_exit_wraps_an_exit_reason_test() ->
    ?assertEqual(
       {'EXIT', boom},
       erlydtl_runtime:capture_exit(fun() -> exit(boom) end)
      ).

capture_exit_wraps_an_error_reason_with_its_stacktrace_test() ->
    Result = erlydtl_runtime:capture_exit(fun() -> error(boom) end),
    ?assertMatch({'EXIT', {boom, Stacktrace}} when is_list(Stacktrace), Result).
