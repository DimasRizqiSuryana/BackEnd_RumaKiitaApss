'use strict';

/**
 * election-voter controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::election-voter.election-voter');
