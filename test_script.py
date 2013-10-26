import requests

class Driver():

    def driver(self):
        for x in range(0,1000):
            requests.get('http://localhost')

if __name__ == '__main__':
    driver = Driver()
    driver.driver()