# Original credit: https://github.com/WizTeam/WizQTClient

find_package(Qt5 REQUIRED Core Gui Widgets Xml Network Concurrent)
get_filename_component(qt_binary_dir ${Qt5_DIR}/../../../bin/ ABSOLUTE)
get_filename_component(qt_translations_dir ${Qt5_DIR}/../../../translations/ ABSOLUTE)
set(QT_VERSION ${Qt5_VERSION})

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

macro(qt_add_translation)
    set(_files)
    foreach(_file ${ARGV})
        if(NOT ${_file} STREQUAL ${ARGV0})
            list(APPEND _files ${_file})
        endif()
    endforeach()

    qt5_add_translation(${ARGV0} ${_files})
endmacro()

macro(qt_add_ui)
    set(_files)
    foreach(_file ${ARGV})
        if(NOT ${_file} STREQUAL ${ARGV0})
            list(APPEND _files ${_file})
        endif()
    endforeach()

    qt5_wrap_ui(${ARGV0} ${_files})
endmacro()

macro(qt_moc_headers)
    set(_files)
    foreach(_file ${ARGV})
        if(NOT ${_file} STREQUAL ${ARGV0})
            list(APPEND _files ${_file})
        endif()
    endforeach()

    qt5_wrap_cpp(${ARGV0} ${_files})
endmacro()

macro(qt_add_resources)
    set(_files)
    foreach(_file ${ARGV})
        if(NOT ${_file} STREQUAL ${ARGV0})
            list(APPEND _files ${_file})
        endif()
    endforeach()
    message(STATUS ${_files})

    qt5_add_resources(${ARGV0} ${_files})
endmacro()

macro(qt_use_modules)
    if(APPLE)
        qt5_use_modules(${ARGV0} Core Gui Widgets Xml Network Concurrent MacExtras)
    else(APPLE)
        qt5_use_modules(${ARGV0} Core Gui Widgets Xml Network Concurrent)
    endif(APPLE)
endmacro()

macro(qt_suppress_warnings)
    if(APPLE)
        set_target_properties(${ARGV0} PROPERTIES
            COMPILE_FLAGS "-Wno-#warnings")
    endif(APPLE)
endmacro()
