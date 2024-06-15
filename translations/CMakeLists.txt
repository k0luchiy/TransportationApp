set(TS_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/TransportationApp_en.ts
    ${CMAKE_CURRENT_SOURCE_DIR}/TransportationApp_ru.ts
)

# Update translations
add_custom_target(update_translations ALL
    COMMAND lupdate ${CMAKE_SOURCE_DIR} -ts ${TS_FILES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Updating translation files..."
)

# Release translations
add_custom_target(release_translations ALL
    COMMAND lrelease ${TS_FILES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Releasing translation files..."
)

#qt6_add_translation(QM_FILES ${TS_FILES})
#install(FILES ${QM_FILES} DESTINATION translations)
