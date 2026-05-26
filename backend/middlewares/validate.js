// ============================================
// middleware/validate.js
// Request body validation middleware
// Usage: router.post('/route', validate(schema), handler)
// ============================================

/**
 * Lightweight schema validator — no external dependencies.
 * Each schema is an object where keys are field names and
 * values are rule objects: { required, type, min, max, enum, regex }
 */
function validate(schema) {
    return (req, res, next) => {
        const errors = [];
        const body = req.body || {};

        for (const [field, rules] of Object.entries(schema)) {
            const value = body[field];
            const isEmpty = value === undefined || value === null || value === '';

            // Required check
            if (rules.required && isEmpty) {
                errors.push(`'${field}' is verplicht.`);
                continue;
            }

            // Skip further checks if field is optional and empty
            if (isEmpty) continue;

            // Type check
            if (rules.type === 'string' && typeof value !== 'string') {
                errors.push(`'${field}' moet een tekst zijn.`);
                continue;
            }
            if (rules.type === 'number' && isNaN(Number(value))) {
                errors.push(`'${field}' moet een getal zijn.`);
                continue;
            }
            if (rules.type === 'email') {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    errors.push(`'${field}' moet een geldig e-mailadres zijn.`);
                    continue;
                }
            }

            // Min length (strings) / min value (numbers)
            if (rules.min !== undefined) {
                if (typeof value === 'string' && value.length < rules.min) {
                    errors.push(`'${field}' moet minimaal ${rules.min} tekens bevatten.`);
                }
                if (typeof value === 'number' && value < rules.min) {
                    errors.push(`'${field}' moet minimaal ${rules.min} zijn.`);
                }
            }

            // Max length (strings) / max value (numbers)
            if (rules.max !== undefined) {
                if (typeof value === 'string' && value.length > rules.max) {
                    errors.push(`'${field}' mag maximaal ${rules.max} tekens bevatten.`);
                }
            }

            // Enum check
            if (rules.enum && !rules.enum.includes(value)) {
                errors.push(`'${field}' moet een van de volgende waarden zijn: ${rules.enum.join(', ')}.`);
            }

            // Custom regex
            if (rules.regex && !rules.regex.test(value)) {
                errors.push(rules.regexMessage || `'${field}' heeft een ongeldig formaat.`);
            }
        }

        if (errors.length > 0) {
            return res.status(400).json({ error: errors[0], errors });
        }

        next();
    };
}

// ============================================
// REUSABLE SCHEMAS
// ============================================

const schemas = {

    register: {
        name:     { required: true,  type: 'string', min: 2, max: 100 },
        email:    { required: true,  type: 'email' },
        password: { required: true,  type: 'string', min: 6, max: 100 },
        account_type: { required: false, enum: ['individual', 'business'] },
    },

    login: {
        email:    { required: true, type: 'email' },
        password: { required: true, type: 'string', min: 1 },
    },

    forgotPassword: {
        email: { required: true, type: 'email' },
    },

    resetPassword: {
        token:    { required: true,  type: 'string', min: 1 },
        password: { required: true,  type: 'string', min: 6, max: 100 },
    },

    createJob: {
        title:   { required: true,  type: 'string', min: 2, max: 150 },
        branche: { required: true,  type: 'string' },
        description:      { required: false, type: 'string', max: 5000 },
        district:         { required: false, type: 'string' },
        hours:            { required: false, type: 'string' },
        experience_level: { required: false, type: 'string' },
        salary:           { required: false, type: 'string', max: 50 },
    },

    applyJob: {
        // No body fields required — user is inferred from JWT
    },

    createMarketItem: {
        name:  { required: true, type: 'string', min: 2, max: 150 },
        price: { required: true, type: 'string', min: 1, max: 50  },
        description:    { required: false, type: 'string', max: 5000 },
        category:       { required: false, type: 'string' },
        condition_type: { required: false, type: 'string' },
        district:       { required: false, type: 'string' },
    },

    createService: {
        name:    { required: true,  type: 'string', min: 2, max: 150 },
        branche: { required: true,  type: 'string' },
        description: { required: false, type: 'string', max: 5000 },
        district:    { required: false, type: 'string' },
        price_range: { required: false, type: 'string' },
        contact:     { required: false, type: 'string', max: 100 },
    },

    updateProfile: {
        job_title:        { required: false, type: 'string', max: 100 },
        bio:              { required: false, type: 'string', max: 2000 },
        phone:            { required: false, type: 'string', max: 30  },
        district:         { required: false, type: 'string' },
        branche:          { required: false, type: 'string' },
        work_type:        { required: false, type: 'string' },
        experience_level: { required: false, type: 'string' },
        education:        { required: false, type: 'string' },
        website:          { required: false, type: 'string', max: 255 },
    },

    sendMessage: {
        message: { required: true, type: 'string', min: 1, max: 5000 },
    },

    addSkill: {
        skill: { required: true, type: 'string', min: 1, max: 100 },
    },

    switchMode: {
        mode: { required: true, enum: ['individual', 'business'] },
    },

    updateApplicationStatus: {
        status: { required: true, enum: ['pending', 'accepted', 'rejected'] },
    },
};

module.exports = { validate, schemas };
