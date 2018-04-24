module.exports = function (app) {
  // var app = this.app || this;
  const check_request = function (req) {
    if (typeof req.device === 'undefined') {
      throw new Error('Must enable the device capture by using app.use(device.capture())');
    }

    return true;
  };

  const is_desktop = function (req, res, next) {
    check_request(req);
    res.locals.is_desktop = req.device.type === 'desktop';
    if (next) {
      next();
    }
  };
  app.use(is_desktop);
  const is_mobile = function (req, res, next) {
    check_request(req);
    res.locals.is_mobile = req.device.type === 'phone' || req.device.type === 'tablet';
    if (next) {
      next();
    }
  };
  app.use(is_mobile);
  const is_phone = function (req, res, next) {
    check_request(req);
    res.locals.is_phone = req.device.type === 'phone';
    if (next) {
      next();
    }
  };
  app.use(is_phone);
  const is_tablet = function (req, res, next) {
    check_request(req);
    res.locals.is_tablet = req.device.type === 'tablet';
    if (next) {
      next();
    }
  };
  app.use(is_tablet);
  const is_tv = function (req, res, next) {
    check_request(req);
    res.locals.is_tv = req.device.type === 'tv';
    if (next) {
      next();
    }
  };
  app.use(is_tv);
  const is_bot = function (req, res, next) {
    check_request(req);
    res.locals.is_bot = req.device.type === 'bot';
    if (next) {
      next();
    }
  };
  app.use(is_bot);
  const device_type = function (req, res, next) {
    check_request(req);
    res.locals.device_type = req.device.type;
    if (next) {
      next();
    }
  };
  app.use(device_type);
};
