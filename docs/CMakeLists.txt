

find_package(Doxygen REQUIRED)
if(NOT DOXYGEN_FOUND)
    add_custom_target(doxygen COMMAND false COMMENT "Doxygen not found")
    return()
endif()

doxygen_add_docs(doxygen
    ${PROJECT_SOURCE_DIR}/${input}
    CONFIG_FILE "${PROJECT_SOURCE_DIR}/docs/config/Doxyfile"
    COMMENT "Generate HTML documentation"
)
