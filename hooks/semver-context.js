#!/usr/bin/env node

const event = process.argv[2] || 'SessionStart';
const context = [
  'When a task concerns release versions, apply Semantic Versioning 2.0.0.',
  'Base the bump on changes to the declared public API: incompatible = MAJOR; backward-compatible functionality or deprecation = MINOR; backward-compatible bug fix = PATCH.',
  'Treat 0.y.z as initial development, never modify a released artifact, reset lower components after a bump, rank pre-releases below the normal version, and ignore build metadata for precedence.',
  'Inspect evidence before recommending a bump; do not infer breaking changes from commit labels alone.'
].join(' ');

if (process.env.PLUGIN_DATA) {
  process.stdout.write(JSON.stringify({
    systemMessage: 'SEMVER:2.0.0',
    hookSpecificOutput: { hookEventName: event, additionalContext: context }
  }));
} else if (event === 'SubagentStart') {
  process.stdout.write(JSON.stringify({
    hookSpecificOutput: { hookEventName: event, additionalContext: context }
  }));
} else {
  process.stdout.write(context);
}
