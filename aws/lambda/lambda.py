def my_lambda(event, context):
    '''The name of this sub must match the lambda handler, and the two 
    parameters are required.'''
    
    # Return whatever you like.
    return [ 
             { "context_function_name": context.function_name },
             { "event": event },
             { "test": "one", "result": "pass" },
             { "test": "two", "result": "pass" }
           ]
