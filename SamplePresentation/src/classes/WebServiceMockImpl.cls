@isTest
global class WebServiceMockImpl implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
           OptimeltofrisoServicecls.updateMemberfromOptimelResponse_element responseElement= new OptimeltofrisoServicecls.updateMemberfromOptimelResponse_element();
            responseElement.result= 'test';
            response.put('response_x', responseElement);
       		//response.put('response_x', 'respElement');
    }
}