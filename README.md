# powershell_scripts
ETRO Powershell scripts

Use this Github repo for storing Powershell scripts for use with PDQ Connect. To invoke a Powershell script on a PDQ Connect agent, simply paste in the RAW URI of the Github script into this cmdlet in the PDQ Connect Powershell console:

iwr -Uri "place_URI_here" -UseBasicParsing | Invoke-Expression

Note also that you can easily run a remote speed test (OKLA) using this Powershell script:

irm http://asheroto.com/speedtest | iex
