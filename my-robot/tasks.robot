*** Settings ***
Documentation       Robot to solve the first challenge at rpachallenge.com,
...                 which consists of filling a form that randomly rearranges
...                 itself for ten times, with data taken from a provided
...                 Microsoft Excel file.

Library             RPA.Browser.Selenium
Library             RPA.Excel.Files
Library             RPA.HTTP