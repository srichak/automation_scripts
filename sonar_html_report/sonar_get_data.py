from sonarqube_api import SonarAPIHandler
import os

username = os.environ.get('USERNAME')
password = os.environ.get('PASSWORD')
project = os.environ.get('PROJECT')
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

fileOutput = open('report_new.html', "wb")

fileOutput.write('<h1>SonarQube Results for ' + project + ' project</h1>\n')
fileOutput.write('<table border="0" style="width: 100%;">\n')
fileOutput.write('<tr>\n')
fileOutput.write('<td>\n')
fileOutput.write('<h2>Summary</h2>\n')
fileOutput.write('<div id="stepContainerSummary">\n')
fileOutput.write('<table border="0">\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td width="250" class="scenarioSuccess">Total issues: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + totalIssues + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write('<td class="scenarioSuccess">Blocker issues: </td>\n')
fileOutput.write('<td class="scenarioSuccessValue"><strong>' +
                    blockerIssues + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Critical issues: </td>\n')
fileOutput.write('<td class="scenarioSuccessValue"><strong>' +
                    criticalIssues + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write('<td class="scenarioSuccess">Major issues: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + majorIssues + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write('<td class="scenarioSuccess">Minor issues: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + minorIssues + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write('<td class="scenarioSuccess">Info issues: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + infoIssues + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write('<td class="scenarioSuccess">Technical debt: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + techDebt + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Technical debt ratio: </td>\n')
fileOutput.write('<td class="scenarioSuccessValue"><strong>' +
                    techDebtRatio + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Total lines of code: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + totalLines + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Non commenting lines of code: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + totalNCLOC + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Total complexity: </td>\n')
fileOutput.write(
    '<td class="scenarioSuccessValue"><strong>' + complexity + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Function complexity: </td>\n')
fileOutput.write('<td class="scenarioSuccessValue"><strong>' +
                    functionComplexity + '/function</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">File complexity: </td>\n')
fileOutput.write('<td class="scenarioSuccessValue"><strong>' +
                    fileComplexity + '/file</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Duplications ratio: </td>\n')
fileOutput.write('<td class="scenarioSuccessValue"><strong>' +
                    duplicationsRatio + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('<tr>\n')
fileOutput.write(
    '<td class="scenarioSuccess">Duplicated lines: </td>\n')
fileOutput.write('<td class="scenarioSuccessValue"><strong>' +
                    duplicatedLines + '</strong></td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('</table>\n')
fileOutput.write('</div>\n')
fileOutput.write('</td>\n')
fileOutput.write('</tr>\n')
fileOutput.write('</table>\n')

fileOutput.close()
