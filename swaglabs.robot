*** Settings ***
Library    SeleniumLibrary
Library         DebugLibrary
*** Variables ***
${message}    My Message
${URL}    https://www.saucedemo.com
${PRODUCT_PAGE}    ${URL}/inventory.html
${BROWSER}    chrome
${ERROR MESSAGE}    Epic sadface: Username and password do not match any user in this service
${PRODUCT LIST}    Sauce Labs Backpack
${PRODUCT PRICE}    $29.99
${complete}    Thank you for your order!

*** Keywords ***

Say Hello
    Log To Console    Ngern

SWAG-001
    Open Browser   ${URL}     browser=${BROWSER}
    Input Text    id=user-name   standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button
    Location Should Be    ${PRODUCT_PAGE}

SWAG-002
    Open Browser    ${URL}    browser=${BROWSER}
    Input Text    id=user-name   standard_user
    Input Text    id=password    secret_sauce123
    Click Button    id=login-button
    Element Text Should Be    xpath=//div/h3[@data-test="error"]    ${ERROR MESSAGE}
    # Sleep    2
    
SWAG-003
    Open Browser    ${URL}  browser=${BROWSER}
    Input Text    id=user-name   standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button
    Click Button    id=add-to-cart-sauce-labs-backpack
    Element Should Contain    xpath=//div/a[@class="shopping_cart_link"]/span    1
    # Sleep    1

SWAG-004
    Open Browser    ${URL}  browser=${BROWSER}
    Input Text    id=user-name   standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button
    Click Button    id=add-to-cart-sauce-labs-backpack
    Click Button    id=remove-sauce-labs-backpack
    Element Should Not Be Visible    xpath=//div/a[@class="shopping_cart_link"]/span 


SWAG-005
    Open Browser    ${URL}  browser=${BROWSER}
    Input Text    id=user-name   standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button
    Click Button    id=add-to-cart-sauce-labs-backpack
    Element Should Contain    xpath=//div/a[@class="shopping_cart_link"]/span    1
    Click Link    xpath=//div[@id="shopping_cart_container"]/a
    Element Text Should Be    xpath=//div[@class="inventory_item_name"]   ${PRODUCT LIST}
    Element Text Should Be    xpath=//div[@class="inventory_item_price"]   ${PRODUCT PRICE}
    Click Button    id=checkout
    Input Text    id=first-name   automate
    Input Text    id=last-name    test
    Input Text    id=postal-code    12345
    Click Button    id=continue
    Element Text Should Be    xpath=//div[@class="inventory_item_name"]   ${PRODUCT LIST}
    Element Text Should Be    xpath=//div[@class="inventory_item_price"]   ${PRODUCT PRICE}
    Click Button    id=finish
    Element Text Should Be    xpath=//div[@class="checkout_complete_container"]/h2[@class="complete-header"]   ${complete}

SWAG-006
    Open Browser   ${URL}     browser=${BROWSER}
    Input Text    id=user-name   standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button
    Click Button    id=react-burger-menu-btn
    # Click Link    xpath=//a[@id="logout_sidebar_link"]
    Sleep    1
    Click Element    xpath=//a[@id="logout_sidebar_link"]
    Sleep    1
    Location Should Be    https://www.saucedemo.com/

*** Test cases ***
Test print text
    SWAG-001
    SWAG-002
    SWAG-003
    SWAG-004
    SWAG-005
    SWAG-006

 