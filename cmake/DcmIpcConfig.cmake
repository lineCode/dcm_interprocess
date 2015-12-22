# - Try to find DCM IPC
# Once done this will define
#  DCMIPC_FOUND - System has DCM IPC
#  DCMIPC_INCLUDE_DIRS - The DCM IPC include directories
#  DCMIPC_LIBRARIES - The libraries needed to use DCM IPC
#  DCMIPC_DEFINITIONS - Compiler switches required for using DCM IPC

add_definitions(-std=c++1z -DASIO_STANDALONE -DBOOST_LOG_DYN_LINK)

FIND_PACKAGE(Boost 1.58 COMPONENTS log REQUIRED)
FIND_PACKAGE(Boost 1.58 COMPONENTS system REQUIRED)
FIND_PACKAGE(Boost 1.58 COMPONENTS filesystem OPTIONAL)

find_path(DCMIPC_INCLUDE_DIR interprocess/listener_fctory.hpp PATH_SUFFIXES dcm )

# FIXME: failed to find stdc++fs
FIND_LIBRARY(STDCPP_FS stdc++fs)

if (STDCPP_FS)
    message(STATUS "Using stdc++ filesystem library")
    set(FS_LIB ${STDCPP_FS})
    add_definitions(-DUSE_STD_FS)
else()
    set(FS_LIB ${Boost_FILESYSTEM_LIBRARY})
endif()

set(DCMIPC_INCLUDE_DIRS, ${DCMIPC_INCLUDE_DIR})
set(DCMIPC_LIBRARIES ${Boost_SYSTEM_LIBRARY} ${Boost_LOG_LIBRARY} ${FS_LIB} pthread rt)

mark_as_advanced(DCMIPC_INCLUDE_DIR STDCPP_FS FS_LIB)