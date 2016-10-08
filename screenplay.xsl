<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" version="1.0" indent="yes"/>

  <xsl:key name="location" match="glossary/location" use="@id" />
  <xsl:key name="char" match="glossary/character" use="@id" />
  
  <xsl:template match="screenplay">

    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>
        <!-- US Letter -->
        <fo:simple-page-master page-height="279mm" page-width="216mm"
                               margin-left="5mm"
                               margin-right="5mm"
                               margin-top="0mm"
                               margin-bottom="0mm"
                               master-name="PageMaster">
          <fo:region-body margin-left="20mm"
                          margin-right="20mm"
                          margin-top="20mm"
                          margin-bottom="20mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="PageMaster">
        <fo:flow flow-name="xsl-region-body">
          <fo:block font-size="12pt" font-family="monospace">
            <xsl:apply-templates select="body"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
      
    </fo:root>
  </xsl:template>

  <xsl:template match="body">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="scene">
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Handle <location ref="" /> -->
  <xsl:template match="location">
    <fo:block font-weight="bold"
              text-decoration="underline"
              margin-bottom="4mm">
      <xsl:for-each select="key('location', @ref)">
        <xsl:apply-templates/>
      </xsl:for-each>
    </fo:block>
  </xsl:template>

  <!-- Handle <description>...</description> -->
  <xsl:template match="description">
    <fo:block font-style="italic">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <!-- Handle <character ref="" /> -->
  <xsl:template match="character">
    <fo:block text-align="center"
              margin-top="4mm">
      <xsl:for-each select="key('char', @ref)">
        <fo:inline text-transform="uppercase">
          <xsl:apply-templates/>
        </fo:inline>
      </xsl:for-each>
    </fo:block>
  </xsl:template>
  
  <!-- Handle <paren>...</paren> -->
  <xsl:template match="paren">
    <fo:block font-style="italic"
              text-align="left"
              margin-left="44mm"
              margin-right="44mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Handle <dialog>...</dialog> -->
  <xsl:template match="dialog">
    <fo:block text-align="left"
              margin-left="32mm"
              margin-right="32mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
