from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)
model = joblib.load(open("./model/label_classifier_pipe_lsv.pkl", 'rb'))


@app.route("/predict", methods=["GET"])
def predict():
    provision = request.args.get('provision')
    result = model.predict([provision])[0]
    response = {"provision": provision,
                "label": result}
    return jsonify(response)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)