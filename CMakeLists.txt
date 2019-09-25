# Required for automatic linking to qtmain.lib on windows.
cmake_minimum_required(VERSION 2.8.12)

project(Qt-Template CXX)

# Find module includes in corresponding build directories.
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# QT Utilities
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if(UNIX)
    if(COMPILER_SUPPORTS_CXX11)
        if(APPLE)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
        else(APPLE)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
        endif(APPLE)
    elseif(COMPILER_SUPPORTS_CXX0X)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
    else()
            message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
    endif()
endif()

# Source and Include file aggregates.
set(QT_TEMPLATE_PRIVATE
    ${CMAKE_SOURCE_DIR}/src/private/main.cpp
    ${CMAKE_SOURCE_DIR}/src/private/qttemplate.cpp
)
set(QT_TEMPLATE_PUBLIC
    ${CMAKE_SOURCE_DIR}/src/public/qttemplate.h
)
set(QT_TEMPLATE_UI
    ${CMAKE_SOURCE_DIR}/src/ui/qttemplate.ui
)
set(QT_TEMPLATE_RCS
    ${CMAKE_SOURCE_DIR}/resources/Qt_Template.qrc
)

include(QtChooser)
qt_add_ui(QT_TEMPLATE_UI_HEADERS ${QT_TEMPLATE_UI})
qt_moc_headers(QT_TEMPLATE_MOC_HEADERS ${QT_TEMPLATE_PUBLIC})
qt_add_resources(QT_TEMPLATE_RC ${QT_TEMPLATE_RCS})
# qt_add_translation()

set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/src/ui)

message("${CMAKE_PROJECT_NAME} will compile as ${CMAKE_BUILD_TYPE}, using QT: ${QT_VERSION}")

# Windows
add_definitions(-DUNICODE=TRUE)
add_definitions(-D_UNICODE=TRUE)
add_executable(${CMAKE_PROJECT_NAME} WIN32 

    ${QT_TEMPLATE_PRIVATE}
    ${QT_TEMPLATE_PUBLIC}
    ${QT_TEMPLATE_UI_HEADERS}
    ${QT_TEMPLATE_MOC_HEADERS}
    ${QT_TEMPLATE_RC}
)
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES AUTOMOC TRUE)
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES AUTOMOC_MOC_OPTIONS "-DQ_OS_WIN32")
install(TARGETS ${CMAKE_PROJECT_NAME} RUNTIME DESTINATION bin)
# /Windows

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/resources
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/src/public
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ui
    ${CMAKE_CURRENT_BINARY_DIR}
)

link_directories(
    ${CMAKE_BINARY_DIR}/bin
)

# Wrap the ui files.
qt5_wrap_ui(ui_wrap ${QT_TEMPLATE_UI})
qt5_wrap_cpp(moc_sources ${QT_TEMPLATE_PUBLIC})

target_link_libraries(${CMAKE_PROJECT_NAME} 
  PUBLIC 

  Qt5::Concurrent
  Qt5::Core
  Qt5::Gui
  Qt5::Network
  Qt5::Widgets
  Qt5::WinMain
  Qt5::Xml
)
