const { build } = require('esbuild');
const { readdirSync, mkdirSync, readFileSync, writeFileSync } = require('fs');
const { join } = require('path');
const AdmZip = require('adm-zip');

const HANDLERS_DIR = 'src/infrastructure/handlers';

async function buildLambdas() {
  mkdirSync('./lambdas', { recursive: true });

  const lambdaFolders = readdirSync(join(__dirname, HANDLERS_DIR), {
    withFileTypes: true,
  })
    .filter((dirent) => dirent.isDirectory())
    .map((dirent) => dirent.name);

  console.log(
    `Found ${
      lambdaFolders.length
    } Lambda functions to build: ${lambdaFolders.join(', ')}`
  );

  for (const lambdaName of lambdaFolders) {
    console.log(`\n🔨 Building ${lambdaName}...`);

    mkdirSync(`./lambdas/${lambdaName}`, { recursive: true });

    await build({
      entryPoints: [`${HANDLERS_DIR}/${lambdaName}/index.ts`],
      bundle: true,
      minify: true,
      platform: 'node',
      target: ['node18'],
      outfile: `./lambdas/${lambdaName}/index.js`,
      metafile: true,
      define: {
        'process.env.NODE_ENV': '"production"',
      },
    });

    console.log(`✅ Bundle created for ${lambdaName}`);

    try {
      const zip = new AdmZip();

      zip.addLocalFile(`./lambdas/${lambdaName}/index.js`);

      zip.writeZip(`./lambdas/${lambdaName}.zip`);

      console.log(`📦 Created ${lambdaName}.zip`);
    } catch (error) {
      console.error(`❌ Error creating zip for ${lambdaName}:`, error.message);
      process.exit(1);
    }
  }

  console.log('\n🚀 All Lambda functions built successfully!');
}

buildLambdas().catch((err) => {
  console.error('❌ Build failed:', err);
  process.exit(1);
});
