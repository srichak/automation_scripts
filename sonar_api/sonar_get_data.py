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

file = open('report.html', "a+")
file.write("<p> Test "+ totalIssues +"  </p>")
file.close()
