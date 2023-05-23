*** Settings ***
Documentation       Template robot main suite.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           RPA.HTTP
Library           RPA.Tables
Library           String



*** Variables ***
&{dicionario_estados}    AC=ACRE    AL=ALAGOAS    AP=AMAPA    AM=AMAZONAS
    ...    BA=BAHIA    CE=CEARA    DF=DISTRITO FEDERAL    ES=ESPIRITO SANTO
    ...    GO=GOIAS    MA=MARANHAO    MT=MATO GROSSO    MS=MATO GROSSO DO SUL
    ...    MG=MINAS GERAIS    PA=PARA    PB=PARAIBA    PR=PARANA    PE=PERNAMBUCO
    ...    PI=PIAUI    RJ=RIO DE JANEIRO    RN=RIO GRANDE DO NORTE
    ...    RS=RIO GRANDE DO SUL    RO=RONDONIA    RR=RORAIMA    SC=SANTA CATARINA
    ...    SP=SAO PAULO    SE=SERGIPE    TO=TOCANTINS 
*** Tasks ***
Complete the challenge
    Open Available Browser    https://cnes.datasus.gov.br/pages/estabelecimentos/consulta.jsp
    Main loop
    #${tabela} = Abertura de Arquivo CSV



*** Keywords ***

Abertura de Arquivo CSV
    # Definir o caminho para o arquivo CSV
    [Arguments]    ${caminho_do_arquivo}    
    # Ler o arquivo CSV usando a biblioteca RPA.Tables
    ${tabela}  Read Table From CSV    ${caminho_do_arquivo}
    RETURN  ${tabela}

Preenche Valores
    [Arguments]    ${uf}    ${municipio}
    # aguarda o elemento estado estar visivel, assim que visivel ele é clicado
    Wait Until Element Is Visible    xpath=//select[@ng-model="Estado"]//option[text()='${uf}']
    Click Element    xpath=//select[@ng-model="Estado"]//option[text()='${uf}']
    
    # aguarda o elemento municipal estar visivel, assim que visivel ele é clicado
    Wait Until Element Is Visible    xpath=//select[@ng-model="Municipio"]//option[text()='${municipio}']
    Click Element    xpath=//select[@ng-model="Municipio"]//option[text()='${municipio}']

    # Clica em pesquisar
    Click Button    Pesquisar

    # uma boa pratica seria verificar se a consulta foi realizada com sucesso
Captura tabela
    #RPA.Browser.Selenium.
Main loop
   ${tabela} =  Abertura de Arquivo CSV    C:\\Users\\victo\\Downloads\\LOCALIDADES.csv
    
    ${num_linhas}    Evaluate    len($tabela)
    FOR    ${linha}    IN RANGE     ${num_linhas}
        ${uf}  RPA.Tables.Get table cell    ${tabela}    ${linha}    UF
        ${municipio}    RPA.Tables.Get table cell    ${tabela}  ${linha}    MUNICIPIO
        #${uf} ${dicionario_estados["${uf}"]}
            # Remover acentos da palavra original
    
        ${municipio_uppercase}    Convert To Upper Case    ${municipio}
        #${municipio_uppercase_semacentos} Remove acentos ${municipio_uppercase}


        
        Preenche Valores    ${dicionario_estados["${uf}"]}     ${municipio_uppercase}

    END


