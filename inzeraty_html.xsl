<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xpath-default-namespace="http://inzeraty.cerm47.cz" version="2.0">

    <xsl:template match="/">
        <xsl:result-document href="index.html" method="html">
            <html lang="cs">
                <head>
                    <title>Inzeráty</title>
                    <link rel="stylesheet" href="indexStyles.css"/>
                </head>
                <body>
                    <h1>Seznam inzerátů</h1>
                    <table>
                        <tr>
                            <th>Nadpis</th>
                            <th>Kategorie</th>
                            <th>Cena</th>
                        </tr>
                        <xsl:for-each select="inzeraty/inzerat">
                            <tr>
                                <td>
                                    <a href="{generate-id(nadpis)}.html">
                                        <xsl:value-of select="nadpis"/>
                                    </a>
                                </td>
                                <td>
                                    <xsl:value-of select="kategorie"/>
                                </td>
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="@typ = 'aukce'">
                                            <xsl:value-of select="aktualniCena"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="cena"/>
                                        </xsl:otherwise>
                                    </xsl:choose> Kč </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </body>
            </html>
        </xsl:result-document>

        <!-- Generování stránek pro detail inzerátů -->
        <xsl:for-each select="inzeraty/inzerat">
            <xsl:result-document href="{generate-id(nadpis)}.html" method="html">
                <html lang="cs">
                    <head>
                        <link rel="stylesheet" href="detailStyles.css"/>
                        <title>
                            <xsl:value-of select="nadpis"/>
                        </title>

                    </head>
                    <body>
                        <h1>
                            <a href="index.html">Seznam inzerátů</a>
                        </h1>
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
                        <h3>Popis</h3>
                        <p>
                            <xsl:value-of select="popis"/>
                        </p>
                        <!--informace o položce-->
                        <table>
                            <tr>
                                <th colspan="2">Detaily</th>
                            </tr>
                 

                                <xsl:choose>
                                    
                                    <xsl:when test="@typ = 'aukce'">
                                        <tr>
                                            <td>
                                            <b>Startovací cena</b>
                                        </td>
                                            <td><xsl:value-of select="startovaciCena"/>&#160;Kč</td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                <b>Aktuální cena</b>
                                            </td>
                                            <td><xsl:value-of select="aktualniCena"/>&#160;Kč</td>
                                        </tr>

                                    </xsl:when>
                                    <xsl:otherwise>
                                        <tr><td>
                                            <b>Cena</b>
                                        </td>
                                            <td><xsl:value-of select="cena"/>&#160;Kč</td></tr>
                                        
                                       
                                        <tr>
                                            <td>
                                                <b>Rezervováno</b>
                                            </td>
                                                <xsl:choose>
                                                    <xsl:when test="rezervovano='true'">
                                                        <td>
                                                            ANO
                                                        </td>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <td>
                                                            NE
                                                        </td>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                        </tr>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <tr>
                                    <td>
                                        <b>Datum nahrání</b>
                                    </td>
                                    <td>
                                        <xsl:value-of select="format-date(datumNahrani, '[D]. [M]. [Y]')"/>
                                    </td>
                                </tr>
                               
                            <xsl:choose>
                                <xsl:when test="@typ = 'aukce'">
                                    <tr>
                                        <td>
                                            <b>Datum konce aukce</b>
                                        </td>
                                        <td>
                                            <xsl:value-of select="format-date(datumKonce, '[D]. [M]. [Y]')"/>
                                        </td>
                                    </tr>
                                </xsl:when>
                            </xsl:choose>
                            <tr>
                                <td>
                                    <b>Počet zobrazení</b>
                                </td>
                                <td>
                                    <xsl:value-of select="pocetZobrazeni"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Množství</b>
                                </td>
                                <td>
                                    <xsl:value-of select="mnozstvi"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Kategorie</b>
                                </td>
                                <td>
                                    <xsl:value-of select="kategorie"/>
                                </td>
                            </tr>
                        </table>

                        <!--Informace o prodejci-->
                        <table>
                            <tr>
                                <th colspan="2">Prodejce</th>
                            </tr>
                            <tr>
                                <td>
                                    <b>Jméno a příjmení</b>
                                </td>
                                <td>
                                    <xsl:value-of
                                        select="concat(prodavajici/jmeno, ' ', prodavajici/prijmeni)"
                                    />
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <b>Telefon</b>
                                </td>
                                <td>
                                    <xsl:value-of select="prodavajici/telefon"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Email</b>
                                </td>
                                <td>
                                    <xsl:value-of select="prodavajici/email"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Adresa</b>
                                </td>
                                <td>
                                    <xsl:value-of
                                        select="concat(prodavajici/adresa/ulice, ' ', prodavajici/adresa/cisloPopisne, ', ', prodavajici/adresa/mesto, ' ', prodavajici/adresa/psc)"
                                    />
                                </td>
                            </tr>
                        </table>







                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
