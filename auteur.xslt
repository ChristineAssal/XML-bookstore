<?xml version="1.0" encoding="UTF-8"?>
<!-- Christine Maher Assal
Matricule : 20127404
IFT 3225 TP 1 - Été 2021
Exercice 2 - Phase 3 : Visualisation des données - Vue Auteurs -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:aut="http://www.iro.umontreal.ca/assal/auteurs" 
    xmlns:bib="http://www.iro.umontreal.ca/assal/bibliotheque" 
    xmlns:liv="http://www.iro.umontreal.ca/assal/livres" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs bib aut liv" version="2.0">
    <xsl:output method="xhtml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" encoding="UTF-8" indent="yes" />
   
    <!-- Entrez ici le nom d'un auteur. -->
    <xsl:param name="auteur" select="''" />
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Auteurs</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" />
                <link rel="stylesheet" type="text/css" href="style.css" />
            </head>
            <body>
                <h1>Auteurs</h1>
                <div class="container">
                    <xsl:for-each select="bib:bibliotheque/aut:auteurs/aut:auteur[contains(aut:nom,$auteur)]">
                        <xsl:variable name="auteur_ident" select="@ident" />
                        <table class="table table-dark">
                            <thead>
                                <tr>
                                    <th style="width:100px">Auteur</th>
                                    <td>
                                        <xsl:value-of select="aut:nom"/>
                                        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                                        <xsl:value-of select="aut:prenom"/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>Identifiant unique</th>
                                    <td>
                                        <xsl:value-of select="@ident" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>Adresse</th>
                                    <td>
                                        <xsl:value-of select="aut:adresse/aut:numero" />
                                        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                                        <xsl:value-of select="aut:adresse/aut:rue" />
                                        <br ></br>
                                        <xsl:value-of select="aut:adresse/aut:ville" />
                                        <br ></br>
                                        <xsl:value-of select="aut:adresse/aut:cp" />
                                    </td>
                                </tr>
                                <xsl:if test="aut:commentaire">
                                    <tr>
                                        <th>Commentaire</th>
                                        <td>
                                            <xsl:value-of select="aut:commentaire" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <tr>
                                    <th>Courriel</th>
                                    <td>
                                        <xsl:value-of select="aut:email" />
                                    </td>
                                </tr>
                                <tr class="table-active">
                                    <th>Livre(s)</th>
                                    <td>
                                        <xsl:for-each select="//liv:livres/liv:livre">
                                            <xsl:sort select="liv:prix" order="descending" data-type="number" />
                                            <xsl:if test="contains(@auteurs,$auteur_ident)">
                                                <table class="table table-dark">
                                                    <thead>
                                                        
                                                        <tr class="table-active">
                                                            <th style="width:150px">Titre</th>
                                                            <td>
                                                                <xsl:value-of select="liv:titre" />
                                                            </td>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <th>Langue</th>
                                                            <td>
                                                                <xsl:value-of select="@langue" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Année</th>
                                                            <td>
                                                                <xsl:value-of select="liv:annee" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Prix</th>
                                                            <td>
                                                                <xsl:value-of select="liv:prix" />
                                                            </td>
                                                        </tr>
                                                        <xsl:if test="liv:prix/@devise">
                                                            <tr>
                                                                <th>Devise</th>
                                                                <td>
                                                                    <xsl:value-of select="liv:prix/@devise" />
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                        <xsl:if test="liv:couverture">
                                                            <tr>
                                                                <th>Couverture</th>
                                                                <td>
                                                                    <img width="200" height="300" alt="Image couverture">
                                                                        <xsl:attribute name="src">
                                                                            <xsl:value-of select="liv:couverture" />
                                                                        </xsl:attribute>
                                                                    </img>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                        <xsl:if test="liv:commentaire">
                                                            <tr>
                                                                <th>Commentaire</th>
                                                                <td>
                                                                    <xsl:value-of select="liv:commentaire" />
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                    </tbody>
                                                </table>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>