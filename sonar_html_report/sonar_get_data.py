from sonarqube_api import SonarAPIHandler
import os

username = os.environ.get('USERNAME')
password = os.environ.get('PASSWORD')
# print username
# print password

#self, host, port, user, password, base_path, token
h = SonarAPIHandler(user=username, password=password,
                    host='https://avsdeveng.accenture.com/sonar')
testConn = h.validate_authentication()
# print testConn

metrics = [
    # Violations
    'violations', 'blocker_violations', 'critical_violations',
    'major_violations', 'minor_violations', 'info_violations',
    # Lines of Code
    'lines',  'ncloc',
    # SQUALE aka Technical Debt
    'sqale_index', 'sqale_debt_ratio',
    # Complexity
    'complexity', 'function_complexity', 'file_complexity',
    # Duplications
    'duplicated_lines_density', 'duplicated_lines'
]

proj = next(h.get_resources_metrics(
    resource='org.turner.pctv.application', metrics=metrics))

msrList = proj["msr"]

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
    if d['key'] == 'info_violations':
        infoIssues = d['frmt_val']
    if d['key'] == 'sqale_index':
        techDebt = d['frmt_val']
    if d['key'] == 'sqale_debt_ratio':
        techDebtRatio = d['frmt_val']
    if d['key'] == 'lines':
        totalLines = d['frmt_val']
    if d['key'] == 'ncloc':
        totalNCLOC = d['frmt_val']
    if d['key'] == 'complexity':
        complexity = d['frmt_val']
    if d['key'] == 'function_complexity':
        functionComplexity = d['frmt_val']
    if d['key'] == 'file_complexity':
        fileComplexity = d['frmt_val']
    if d['key'] == 'duplicated_lines_density':
        duplicationsRatio = d['frmt_val']
    if d['key'] == 'duplicated_lines':
        duplicatedLines = d['frmt_val']

print "Total issues: " + totalIssues
print "Blocker Issues: " + blockerIssues
print "Critical Issues: " + criticalIssues
print "Major Issues: " + majorIssues
print "Minor Issues: " + minorIssues
print "Info Issues: " + infoIssues
print "Techical Debt: " + techDebt
print "Technical Debt Ratio: " + techDebtRatio
print "Total Lines of Code: " + totalLines
print "Total non commenting lines of code: " + totalNCLOC
print "Total Complexity: " + complexity
print "Function complexity: " + functionComplexity
print "File complexity: " + fileComplexity
print "Duplications ratio: " + duplicationsRatio
print "Duplicated lines: " + duplicatedLines