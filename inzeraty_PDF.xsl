<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xpath-default-namespace="http://inzeraty.cerm47.cz" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" encoding="UTF-8"/>

    <xsl:template match="/">
        <fo:root font-family="Calibri">
            <!--Nastavení rozložení stránky-->
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4" page-width="210mm" page-height="297mm"
                    margin="10mm">
                    <fo:region-body margin-top="5mm" margin-bottom="5mm"/>
                    <fo:region-before extent="10mm" region-name="xsl-region-before"/>
                    <fo:region-after extent="10mm" region-name="xsl-region-after"/>
                </fo:simple-page-master>
            </fo:layout-master-set>


            <!--Záhlaví a zápatí-->
            <fo:page-sequence master-reference="A4">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="end" space-before="20mm">
                        <xsl:text>Inzeráty</xsl:text>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center">
                        <xsl:text>Strana </xsl:text>
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" margin-bottom="30pt" font-weight="bold" text-align="center" margin-top="20px"> Seznam
                        inzerátů </fo:block>
                    <fo:block font-size="25pt" margin-bottom="5mm" font-weight="bold">Obsah</fo:block>
                    <xsl:apply-templates select="/inzeraty/kategorie"/>
                    <xsl:apply-templates select="/inzeraty"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>


    <!-- Obsah -->
    <xsl:template match="kategorie">

        <fo:block font-size="12pt" font-weight="bold" text-align="justify"
            text-align-last="justify">
            <fo:basic-link internal-destination="{nazev}">
                <xsl:value-of select="nazev"/>
                <fo:leader leader-pattern="dots"/>
                <fo:page-number-citation ref-id="{nazev}"/>
            </fo:basic-link>
        </fo:block>


        <fo:block font-size="10pt" space-after="5mm">
            <xsl:value-of select="popis"/>
        </fo:block>
    </xsl:template>


    <!-- Inzeráty -->
    <xsl:template match="inzeraty">
        
        <xsl:for-each-group select="inzerat" group-by="kategorie">
            <xsl:sort select="kategorie" order="ascending"/>
            <fo:block text-align="center" font-weight="bold" font-size="30"
                page-break-before="always" id="{kategorie}"> Kategorie: <xsl:value-of select="kategorie"/>
            </fo:block >
            
            <xsl:for-each select="current-group()">
                <!--Nadpis-->
                <fo:block font-size="20" font-weight="bold" space-before="10mm">
                    <xsl:value-of select="nadpis"/>
                </fo:block>

                <!--Popis-->
                <fo:block space-before="3mm">
                    <xsl:value-of select="popis"/>
                </fo:block>
                <fo:block text-align="center" space-before="5mm">
                    <fo:external-graphic src="url({foto})" content-width="600px"
                        content-height="338px"/>
                </fo:block>



                <fo:block space-before="15mm" page-break-after="always">
                    <fo:table table-layout="fixed" width="100%">

                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="2" margin="2mm"
                                    border="solid 3px black" background-color="#4CAF50">
                                    <fo:block text-align="center" font-weight="bold" 
                                        >Detaily</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>

                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Typ</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of select="@typ"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Kategorie</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of select="kategorie"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <xsl:choose>
                                <xsl:when test="@typ = 'aukce'">
                                    <fo:table-row>
                                        <fo:table-cell padding="2mm" border="solid 1px black">
                                            <fo:block font-weight="bold"> Startovací cena</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2mm" border="solid 1px black">
                                            <fo:block>
                                                <xsl:value-of select="startovaciCena"/>
                                                Kč</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>

                                    <fo:table-row>
                                        <fo:table-cell padding="2mm" border="solid 1px black">
                                            <fo:block font-weight="bold"> Aktuální cena </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2mm" border="solid 1px black">
                                            <fo:block>
                                                <xsl:value-of select="aktualniCena"/> Kč</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>


                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:table-row>
                                        <fo:table-cell padding="2mm" border="solid 1px black">
                                            <fo:block font-weight="bold">Cena</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2mm" border="solid 1px black">
                                            <fo:block>
                                                <xsl:value-of select="cena"/> Kč</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:otherwise>
                            </xsl:choose>


                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Datum Nahrání</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of
                                            select="format-date(datumNahrani, '[D]. [M]. [Y]')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <xsl:if test="@typ = 'aukce'">
                                <fo:table-row>
                                    <fo:table-cell padding="2mm" border="solid 1px black">
                                        <fo:block font-weight="bold">Datum konce aukce</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="2mm" border="solid 1px black">
                                        <fo:block>
                                            <xsl:value-of
                                                select="format-date(datumKonce, '[D]. [M]. [Y]')"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:if>

                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Množství</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of select="mnozstvi"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Počet Zobrazení</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of select="pocetZobrazeni"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                        </fo:table-body>
                    </fo:table>
                    
                    
                    
                    <fo:table>
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="2" margin="2mm"
                                    border="solid 3px black" background-color="#6897bb">
                                    <fo:block text-align="center" font-weight="bold"
                                        >Prodejce</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>


                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Jméno a příjmení</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of
                                            select="concat(prodavajici/jmeno, ' ', prodavajici/prijmeni)"
                                        />
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Telefon</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of select="prodavajici/telefon"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">E-mail</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of select="prodavajici/email"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <fo:table-row>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block font-weight="bold">Adresa</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2mm" border="solid 1px black">
                                    <fo:block>
                                        <xsl:value-of
                                            select="concat(prodavajici/adresa/ulice, ' ', prodavajici/adresa/cisloPopisne, ', ', prodavajici/adresa/mesto, ' ', prodavajici/adresa/psc)"
                                        />
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:for-each>

        </xsl:for-each-group>

    </xsl:template>
</xsl:stylesheet>
