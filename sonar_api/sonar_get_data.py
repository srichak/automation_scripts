from sonarqube_api import SonarAPIHandler

#self, host, port, user, password, base_path, token
h = SonarAPIHandler(user='k.bernatovics', password='mae6oi6O',
host='https://avsdevops.accenture.com/sonar')
testConn = h.validate_authentication();
print testConn
"""
for project in h.get_resources_full_data(metrics=['coverage', 'violations']):
    # do something with project data...
    print project
"""
metrics = [
# Violations
'violations', 'blocker_violations', 'critical_violations',
'major_violations', 'minor_violations',
# Lines of Code
'lines',  'ncloc',
# SQUALE aka Technical Debt
'sqale_index', 'sqale_debt_ratio'
]

proj = next(h.get_resources_metrics(resource='org.turner.pctv.application', metrics=metrics))
#proj = next(h.get_metrics(fields='violations'))
print proj
print ('\n')
print proj.keys()
print ('\n')
msrList = proj["msr"]
print ('\n')
print msrList
print ('\n')
for d in msrList:
    if d['key'] == 'violations':
        totalIssues = d['frmt_val']
    if d['key'] == 'blocker_violations':
        blockerIssues = d['frmt_val']
    if d['key'] == 'critical_violations':
        criticalIssues = d['frmt_val']
    if d['key'] == 'major_violations':
        majorIssues = d['frmt_val']
    if d['key'] == 'minor_violations':
        minorIssues = d['frmt_val']
    if d['key'] == 'sqale_index':
        techDebt = d['frmt_val']
    if d['key'] == 'sqale_debt_ratio':
        techDebtRatio = d['frmt_val']
    if d['key'] == 'lines':
        totalLines = d['frmt_val']
    if d['key'] == 'ncloc':
        totalNCLOC = d['frmt_val']

print "Total issues: " + totalIssues
print "Blocker Issues: " + blockerIssues
print "Critical Issues: " + criticalIssues
print "Major Issues: " + majorIssues
print "Minor Issues: "  + minorIssues
print "Techical Debt: " + techDebt
print "Technical Debt Ratio: " + techDebtRatio
print "Total Lines of Code: " + totalLines
print "Total non commenting lines of code: " + totalNCLOC

fileInput = open('report.html', "rb")
fileOutput = open('report_new.html',"wb")
for line in fileInput.readlines():
    if '<div class="layout">' in line:
        fileOutput.write(line + '\n<p> Teeeeeeeest: ' + totalIssues + '</p>\n')
        fileOutput.write('<p> More text...</p>\n')
        fileOutput.write('<h1>SonarQube Results</h1>\n')
        fileOutput.write('<table border="0" style="width: 100%;">\n')
        fileOutput.write('<tr>\n')
        fileOutput.write('<td>\n')
	    fileOutput.write('<h2>Summary</h2>\n')
        fileOutput.write('<div id="stepContainerSummary"\n'>)
        fileOutput.write('<table border="0">\n')
        fileOutput.write('<tr>\n')
        fileOutput.write('<td width="250" class="scenarioSuccess">Total issues: </td>\n')
        fileOutput.write('<td class="scenarioSuccessValue"><strong>'+ totalIssues +'</strong></td>\n')
        fileOutput.write('</tr>\n')
        fileOutput.write('</table>\n')
        fileOutput.write('</div>\n')
        fileOutput.write('</td>\n')
        fileOutput.write('</tr>\n')
        fileOutput.write('</table>\n')
    else:
        fileOutput.write(line)
fileInput.close()
fileOutput.close()
