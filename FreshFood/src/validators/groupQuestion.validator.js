const joi = require('@hapi/joi');
const schemas = {
	createGroupQuestion: joi.object().keys({
		title: joi.string().required(),
		isActive: joi.boolean().required()
	}),
	
	updateGroupQuestion: joi.object().keys({
    id: joi.string().required(),
		title: joi.string(),
		isActive: joi.boolean()

	}),
};
module.exports = schemas;


