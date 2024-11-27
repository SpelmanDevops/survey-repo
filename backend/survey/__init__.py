import logging
import json
import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Processing a survey response.")

    try:
        body = req.get_json()
        response = body.get("response")
        if not response:
            return func.HttpResponse("Invalid response", status_code=400)
        
        # Simulate storing the response
        logging.info(f"Stored response: {response}")
        return func.HttpResponse(
            json.dumps({"message": "Response submitted successfully"}),
            mimetype="application/json",
        )
    except Exception as e:
        logging.error(f"Error: {e}")
        return func.HttpResponse("Internal server error", status_code=500)