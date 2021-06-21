<?xml version="1.0" encoding="UTF-8"?>
<!-- Christine Maher Assal
Matricule : 20127404
IFT 3225 TP 1 - Été 2021
Exercice 2 - Phase 3 : Visualisation des données : Vue Livres 
Ressources utilisiées : 
https://stackoverflow.com/questions/1461649/how-to-insert-nbsp-in-xslt/39280677
https://www.oxygenxml.com/archives/xsl-list/200601/msg00294.html-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:aut="http://www.iro.umontreal.ca/assal/auteurs" 
    xmlns:bib="http://www.iro.umontreal.ca/assal/bibliotheque"
    xmlns:liv="http://www.iro.umontreal.ca/assal/livres" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs bib aut liv" version="2.0">
    <xsl:output method="xhtml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" encoding="UTF-8" indent="yes" />
    
    <!-- Entrez ici un intervalle pour le prix (minimum et maximum) -->
    <xsl:param name="prix_minimum" select="0" />
    <xsl:param name="prix_maximum" select="15" />
    
    <xsl:key name="auteur_ident" match="bib:bibliotheque/aut:auteurs/aut:auteur" use="@ident" />
    <xsl:variable name="auteurs" select="bib:bibliotheque/aut:auteurs" />
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Livres</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" />
                <link rel="stylesheet" type="text/css" href="style.css" />
            </head>
            <body>
                <h1>Livres</h1>
                <div class="container">
                    <table class="table table-dark">
                        <thead>
                            <tr>
                                <th scope="col">Titre</th>
                                <th scope="col">Auteur(s)</th>
                                <th scope="col">Langue</th>
                                <th scope="col">Année</th>
                                <th scope="col">Prix</th>
                                <th scope="col">Devise</th>
                                <th scope="col">Commentaire</th>
                                <th scope="col">Couverture</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:choose>
                                <xsl:when test="$prix_minimum or $prix_maximum"> <!-- "or" car number 0 retourne empty -->
                                    <xsl:for-each select="bib:bibliotheque/liv:livres/liv:livre[(number(liv:prix) &gt;= number($prix_minimum) and number(liv:prix) &lt;= number($prix_maximum))]">
                                        <xsl:sort select="key('auteur_ident',tokenize(@auteurs, ' ')[1]) /aut:nom" order="ascending" data-type="text" />
                                        <tr>
                                            <td>
                                                <xsl:value-of select="liv:titre" />
                                            </td>
                                            <td>
                                                <xsl:for-each select="tokenize(@auteurs, ' ')">
                                                    <xsl:value-of select="key('auteur_ident',current(), $auteurs)/aut:nom" />
                                                    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                                                    <xsl:value-of select="key('auteur_ident',current(), $auteurs)/aut:prenom" />
                                                    <br></br>
                                                </xsl:for-each>
                                            </td>
                                            <td>
                                                <xsl:value-of select="@langue" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:annee" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:prix" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:prix/@devise" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:commentaire" />
                                            </td>
                                            <td>
                                                <xsl:if test="liv:couverture">
                                                    <img width="200" height="300" alt="Image couverture">
                                                        <xsl:attribute name="src">
                                                            <xsl:value-of select="liv:couverture" />
                                                        </xsl:attribute>
                                                    </img>
                                                </xsl:if>
                                                <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="bib:bibliotheque/liv:livres/liv:livre">
                                        <xsl:sort select="key('auteur_ident',tokenize(@auteurs, ' ')[1]) /aut:nom" order="ascending" data-type="text" />
                                        <tr>
                                            <td>
                                                <xsl:value-of select="liv:titre" />
                                            </td>
                                            <td>
                                                <xsl:for-each select="tokenize(@auteurs, ' ')">
                                                    <xsl:value-of select="key('auteur_ident',current(), $auteurs)/aut:nom" />
                                                    <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                                                    <xsl:value-of select="key('auteur_ident',current(), $auteurs)/aut:prenom" />
                                                    <br></br>
                                                </xsl:for-each>
                                            </td>
                                            <td>
                                                <xsl:value-of select="@langue" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:annee" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:prix" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:prix/@devise" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="liv:commentaire" />
                                            </td>
                                            <td>
                                                <xsl:if test="liv:couverture">
                                                    <img width="200" height="300" alt="Image couverture">
                                                        <xsl:attribute name="src">
                                                            <xsl:value-of select="liv:couverture" />
                                                        </xsl:attribute>
                                                    </img>
                                                </xsl:if>
                                                <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>