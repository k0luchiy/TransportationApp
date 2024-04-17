qt_add_library(userModels SHARED
    usermodel.cpp usermodel.h
    user.h user.cpp
    rolesmodel.h rolesmodel.cpp
)


target_link_libraries(userModels PRIVATE Qt6::Core PRIVATE Qt6::Sql)
target_include_directories(userModels INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
