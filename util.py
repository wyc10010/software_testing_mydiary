from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from robot.libraries.OperatingSystem import OperatingSystem

class util:

    @keyword(name='Search Results Should Contain Searching Text')
    def search_results_should_contain_searching_text(self, searching_text, search_results):
        if len(search_results) == 0:
            raise Exception('Search Result is empty can not compare with %s' % searching_text)
        if isinstance(searching_text, list):
            if any(result not in searching_text for result in search_results):
                raise Exception('The search result: %s does not meet the searching text: %s'  %(search_results,searching_text))
        else:
            for search_result in search_results:
                if searching_text.upper() not in search_result.upper():
                    raise Exception('This column text %s does not contain searching text %s'  %(search_result,searching_text))