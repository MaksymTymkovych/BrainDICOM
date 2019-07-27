cmake_minimum_required(VERSION 3.1)

project(BrainDICOM LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)






find_package(Qt5 COMPONENTS Core Quick Gui REQUIRED)

SET(DCMTK_DIR "/media/montaindeveloper/371423CD6AE1FE10/Workspaces/cpp/dcmtk")
find_package(DCMTK REQUIRED)
include_directories(${DCMTK_INCLUDE_DIRS})



add_executable(${PROJECT_NAME} "main.cpp" "qml.qrc" "utility.cpp" "dicomimageprovider.cpp" "dicomtagsmodel.cpp")
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Core Qt5::Quick ${DCMTK_LIBRARIES} Qt5::Gui)
