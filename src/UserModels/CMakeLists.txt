qt_add_library(userModels STATIC
    usermodel.cpp
    usermodel.h
    user.h user.cpp
)

target_link_libraries(userModels PRIVATE Qt6::Core)
target_include_directories(userModels INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
