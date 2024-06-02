<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xpath-default-namespace="http://inzeraty.cerm47.cz" version="2.0">

    <xsl:output method="html" encoding="UTF-8" version="5"/>

    <xsl:template match="/">
        <html lang="cs">
            <head>
                <title>Inzeráty</title>
            </head>
            <body>
                <h1>Inzeráty</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="kategorie"/>
    <xsl:template match="inzerat">

        <h2>
            <xsl:value-of select="nadpis"/>
        </h2>
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="foto"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="nadpis"/>
            </xsl:attribute>
        </img>
        <ul>
            <xsl:if test="cena">
                <li>Cena: <xsl:value-of select="cena"/> Kč</li>
            </xsl:if>
            <xsl:if test="startovaciCena">
                <li>Startovací cena: <xsl:value-of select="startovaciCena"/> Kč</li>
                <li>Aktuální cena: <xsl:value-of select="aktualniCena"/> Kč</li>
            </xsl:if>
            <li>Město: <xsl:value-of select="prodavajici/adresa/mesto"/></li>
            <li>Datum nahrání: <xsl:value-of select="datumNahrani"/></li>
            <xsl:if test="datumKonce">
                <li>Konec aukce: <xsl:value-of select="datumKonce"/></li>
            </xsl:if>
            <xsl:if test="rezervovano">
                <xsl:choose>
                    <xsl:when test="rezervovano = 't  rue'">
                        <li>Rezervováno: ANO</li>
                    </xsl:when>
                    <xsl:otherwise>
                        <li>Rezervováno: NE</li>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>    

        <li>Počet zobrazení: <xsl:value-of select="pocetZobrazeni"/></li>
            
        </ul>
    </xsl:template>
</xsl:stylesheet>
