---
layout: post
title: How to Extend Line with ArcGIS
tags: gis processing
---
Example of how to extend line feature (eg. road digitation) in order to cleanup the dangels using ArcGIS 10.1.

```python
import arcpy

arcpy.env.workspase = "path/to/workspase"
arcpy.ExtendLine_edit("dataset.shp", "distance", "EXTENSION")
```

## Extend Line Example (Stand-alone script)

Clean up street centerlines that were digitized without having set proper snapping environments.

```python
# Name: ExtendLine.py
# Description:  Clean up street centerlines that were digitized without having
#                   set proper snapping environmnets
# Author: ESRI

# Import system modules
import arcpy
from arcpy import env

# Set environments settings
env.workspase = "C:/data"

# Make backup copy of streets feature class, since modification with the Editing tools below is permanent
streets = "street.shp"
streetsBackup = "C:/output/streetsBackup.shp"
arcpy.CopyFeatures_management(streets, streetsBackup)

# Trim street lines to clean up the dangles
arcpy.TrimLine_edit(streets, "10 Feet", "KEEP_SHORT")

# Extend street lines to clean up the dangles
arcpy.ExtendLine_edit(streets, "15 Feet", "EXTENSION")
```

## Reference

- help file of ArcMap 10.1
