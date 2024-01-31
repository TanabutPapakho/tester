*** Settings ***
Library    SeleniumLibrary
Library         DebugLibrary
Test Setup    Open Browser    ${URL}    browser=${BROWSER}
Test Teardown    Close Browser
*** Variables ***
${message}    My Message
${URL}    https://www.saucedemo.com
${URLLOGOUT}    https://www.saucedemo.com/
${PRODUCT_PAGE}    ${URL}/inventory.html
${BROWSER}    chrome
${ERROR MESSAGE}    Epic sadface: Username and password do not match any user in this service
${PRODUCT LIST}    Sauce Labs Backpack
${PRODUCT PRICE}    $29.99
${complete}    Thank you for your order!

*** Keywords ***
LoginSwaglabs
    [Arguments]    ${username}    ${password}
    Input Text    id=user-name   ${username}
    Input Text    id=password    ${password}
    Click Button    id=login-button

Check location
    [Arguments]    ${URLCheck}
    Location Should Be    ${URLCheck}

Check element text
    [Arguments]    ${XPATH}    ${TEXT}
    Element Text Should Be     ${XPATH}    ${TEXT}

Click add to cart
    [Arguments]    ${XPATH}
    Click Button    ${XPATH}

Verify item number after add cart
    [Arguments]    ${XPATH}    ${Number}
    Element Should Contain    ${XPATH}    ${Number}

Click Remove to cart
    [Arguments]    ${XPATH}
    Click Button    ${XPATH}

Check not show number of items in cart
    [Arguments]    ${XPATH}
    Element Should Not Be Visible     ${XPATH}

Check Out
    [Arguments]    ${firstname}    ${lastname}    ${postalcode}
    Click Button    id=checkout
    Input Text    id=first-name   ${firstname}
    Input Text    id=last-name    ${lastname}
    Input Text    id=postal-code    ${postalcode}
    Click Button    id=continue

Check Text checkout
    Check element text    xpath=//div[@class="inventory_item_name"]   ${PRODUCT LIST}
    Check element text    xpath=//div[@class="inventory_item_price"]   ${PRODUCT PRICE}

Click finish
    Click Button    id=finish
    Check element text    xpath=//div[@class="checkout_complete_container"]/h2[@class="complete-header"]   ${complete}

Click burger
    Click Button    id=react-burger-menu-btn

Click checkout
    Click Link    xpath=//div[@id="shopping_cart_container"]/a

Click logout sidebar
    Click Element    xpath=//a[@id="logout_sidebar_link"]

*** Test cases ***
SWAG-001 User be able to login with valid username and password
    LoginSwaglabs    standard_user    secret_sauce
    Check location    ${PRODUCT_PAGE}

SWAG-002 User not be able to login with valid username and password
    LoginSwaglabs    standard_user    secret_sauce123
    Check element text    xpath=//div/h3[@data-test="error"]    ${ERROR MESSAGE}

SWAG-003 User able to add product to cart
    LoginSwaglabs    standard_user    secret_sauce
    Click add to cart    id=add-to-cart-sauce-labs-backpack
    Verify item number after add cart    xpath=//div/a[@class="shopping_cart_link"]/span    1

SWAG-004 User able to remove product to cart
    LoginSwaglabs    standard_user    secret_sauce
    Click add to cart     id=add-to-cart-sauce-labs-backpack
    Click Remove to cart    id=remove-sauce-labs-backpack
    Check not show number of items in cart    xpath=//div/a[@class="shopping_cart_link"]/span

SWAG-005 User able to checkout
    LoginSwaglabs    standard_user    secret_sauce
    Click add to cart    id=add-to-cart-sauce-labs-backpack
    Verify item number after add cart    xpath=//div/a[@class="shopping_cart_link"]/span    1
    Click checkout
    Check Text checkout
    Check Out    automated    tester    40000
    Check Text checkout

SWAG-006 User able to logout
    LoginSwaglabs    standard_user    secret_sauce
    Click burger
    Wait Until Element Is Visible    xpath=//a[@id="logout_sidebar_link"]
    Click logout sidebar
    Check location    ${URLLOGOUT}
