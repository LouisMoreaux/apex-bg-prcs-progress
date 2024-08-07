# apex-bg-prcs-progress
Region plug-in that allows you to monitor the background process execution in your Oracle APEX application

<img alt="Screen recording showing the APEX Background Process Progress plug-in" src="https://github.com/LouisMoreaux/apex-bg-prcs-progress/blob/main/assets/apex-bg-prcs-progress.gif?raw=true" ></img>

## Installation
Import the file located at plug-in/region_type_plugin_apex_lmoreaux_bgd_process_progress

## configuration
### Region attributes
<table>
<tr>
<td> Attribute </td> <td> Description </td>
</tr>
<tr>
<td> Execution Id </td>
<td> Page item containing the Execution ID you wish to monitor.</td>
</tr>
<tr>
<td> Progress Type </td>
<td> Type of progress (Bar or Circular). </td>
</tr>
<tr>
<td> Display Percentage? </td>
<td> Display the completion percentage (Y/N) </td>
</tr>
<tr>
<td> Display Status? </td>
<td> Display the execution status (Y/N) </td>
</tr>
<tr>
<td> Color Variable </td>
<td> Choose the color.<br>Based on the Universal Theme colors, more info <a href="https://apex.oracle.com/pls/apex/r/apex_pm/ut/color-and-status-modifiers">here</a>. </td>
</tr>
<tr>
<td> Width </td>
<td> Width or the Progress Bar. </td>
</tr>
<tr>
<td> Height </td>
<td> Height of the Progress Bar. </td>
</tr>
<tr>
<td> Size </td>
<td> Size of the circular progress </td>
</tr>
<tr>
<td> Redirect On Completion? </td>
<td> Redirect on execution completion (Y/N) </td>
</tr>
<tr>
<td> Redirect Link </td>
<td> Link to redirect the user upon completion. </td>
</tr>
</table>

### Component attributes
<table>
<tr>
<td> Attribute </td> <td> Description </td>
</tr>
<tr>
<td> Max Iteration </td>
<td> Maximum number of iteration.</td>
</tr>
<tr>
<td> Sleep Time </td>
<td> Waiting time between two AJAX call to get the execution status. </td>
</tr>
<tr>
</table>

## Demo
A live demo can be found at [https://apex.oracle.com/pls/apex/r/louis/plug-ins/background-processes](https://apex.oracle.com/pls/apex/r/louis/plug-ins/background-processes)
