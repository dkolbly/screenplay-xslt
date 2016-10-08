<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" version="1.0" indent="yes"/>

  <xsl:key name="location" match="glossary/location" use="@id" />
  <xsl:key name="char" match="glossary/character" use="@id" />
  
  <xsl:template match="screenplay">

    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>
        <fo:simple-page-master page-height="297mm" page-width="210mm"
                               margin="5mm 25mm 5mm 25mm"
                               master-name="PageMaster">
          <fo:region-body margin="20mm 0mm 20mm 0mm"/>
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
    <fo:inline font-weight="bold" text-decoration="underline">
      <xsl:for-each select="key('location', @ref)">
        <xsl:apply-templates/>
      </xsl:for-each>
    </fo:inline>
  </xsl:template>

  <!-- Handle <description>...</description> -->
  <xsl:template match="description">
    <fo:block font-style="italic">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <!-- Handle <character ref="" /> -->
  <xsl:template match="character">
    <fo:block text-align="center">
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
              text-align="right"
              margin-left="30mm"
              margin-right="30mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Handle <dialog>...</dialog> -->
  <xsl:template match="dialog">
    <fo:block text-align="left"
              margin-left="30mm"
              margin-right="30mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
