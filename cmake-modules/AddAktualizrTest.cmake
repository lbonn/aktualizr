
function(add_aktualizr_test)
    set(options PROJECT_WORKING_DIRECTORY NO_VALGRIND)
    set(oneValueArgs NAME)
    set(multiValueArgs SOURCES ARGS)
    cmake_parse_arguments(AKTUALIZR_TEST "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    add_executable(t_${AKTUALIZR_TEST_NAME} ${AKTUALIZR_TEST_SOURCES})
    target_link_libraries(t_${AKTUALIZR_TEST_NAME} aktualizr_static_lib testutilities ${TEST_LIBS} gtest gmock)
    target_include_directories(t_${AKTUALIZR_TEST_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/tests)
    if(AKTUALIZR_TEST_PROJECT_WORKING_DIRECTORY)
        set(WD WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
    else()
        set(WD )
    endif()
        # Running tests that are both instrumented by gcov and valgrind at
        # the same time is very expensive.  Disable valgrind when running
        # under gcov, or when the test is explicitly flagged that it fails
        # under valgrind (these should be fixed)
        if(AKTUALIZR_TEST_NO_VALGRIND OR BUILD_WITH_CODE_COVERAGE)
            add_test(NAME test_${AKTUALIZR_TEST_NAME}
                     COMMAND t_${AKTUALIZR_TEST_NAME} ${AKTUALIZR_TEST_ARGS}
                     ${WD})
        else()
            add_test(NAME test_${AKTUALIZR_TEST_NAME}
                     COMMAND ${RUN_VALGRIND} ${CMAKE_CURRENT_BINARY_DIR}/t_${AKTUALIZR_TEST_NAME} ${AKTUALIZR_TEST_ARGS}
                     ${WD})
        endif()
    add_dependencies(build_tests t_${AKTUALIZR_TEST_NAME})
    set(TEST_SOURCES ${TEST_SOURCES} ${AKTUALIZR_TEST_SOURCES} PARENT_SCOPE)
endfunction(add_aktualizr_test)