<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">    
    <sch:ns uri="http://inzeraty.cerm47.cz" prefix="o"/>  
    
    <sch:pattern>
        <sch:title>Kontrola cen</sch:title>
        <sch:rule context="o:inzeraty/o:inzerat[o:aktualniCena]">
            <sch:assert test="o:startovaciCena &lt;= o:aktualniCena">aktualniCena nemůže být nižší, než startovaciCena</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>Kontrola datumu</sch:title>
        <sch:rule context="o:inzeraty/o:inzerat[o:datumKonce]">
            <sch:assert test="o:datumNahrani &lt;= o:datumKonce">datumNahrani nemuze byt pozdeji, nez datumKonce.</sch:assert>
        </sch:rule>   
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="o:inzeraty/o:inzerat">
            <sch:assert test="o:nadpis">U inzerátu musí být vyplněný nadpis</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>