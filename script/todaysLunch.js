const URL = 'https://lunch.jp-east-2.os.cloud.nifty.com/lunch.json';

let http = require('https');
module.exports = (req, res) => {
  http.get(URL, (result) => {
    let body = '';
    result.setEncoding('utf8');

    result.on('data', (chunk) => {
      body += chunk;
    });

    result.on('end', (result) => {
      data = JSON.parse(body);
      let max = 0;
      data.foods.forEach(d => {
        max += d["rate"];
      });

      let rate = Math.floor(Math.random() * max);
      for (var d of data.foods) {
        max -= d["rate"];
        if (max <= rate) {
          res.send(JSON.stringify(d));
        }
      }
    });
  });
}
