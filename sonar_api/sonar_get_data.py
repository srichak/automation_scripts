from sonarqube_api import SonarAPIHandler

print 'python output test'

#self, host, port, user, password, base_path, token
h = SonarAPIHandler(user='k.bernatovics', password='mae6oi6O',
host='https://avsdevops.accenture.com/sonar/')
h.validate_authentication();
#for project in h.get_resources_full_data(metrics=['coverage', 'violations']):
    # do something with project data...
    #print project.coverage
    #print project.violations
