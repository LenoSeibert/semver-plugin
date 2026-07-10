#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const event = process.argv[2] || 'SessionStart';
const context = fs.readFileSync(path.join(__dirname, '..', 'AGENTS.md'), 'utf8');

process.stdout.write(JSON.stringify({
  hookSpecificOutput: { hookEventName: event, additionalContext: context }
}));
