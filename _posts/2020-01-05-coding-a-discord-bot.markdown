---
layout: post
title: 'Coding a Discord Bot'
date: 2020-01-05 23:51:58 -0500
categories: discord node.js javascript
---

### Assumptions

You should already have a discord server and account in order to follow this tutorial.

### Setting Up Discord App

Navigate over to [https://discordapp.com/developers/applications](https://discordapp.com/developers/applications) and click the New Application button:

Give a name to your application; it doesn't really matter what you name it.

After making the Application, click the Bot tab on the settings navigation on the left of the page. Continue through the steps to create your bot and name it something fun. After your bot is ready, copy the token by clicking the copy button. You'll use this when writing the javascript code.

### Coding our Javascript Discord Bot

Create a new project folder and setup npm using whatever approach you normally use. I typically run this:

`npm init -y`

Now install the `discord.js` npm package into your project like so:

`npm i --save discord.js`

At this point, we are ready to code. Copy the following code into a file named `index.js`:

```
const Discord = require('discord.js');
const client = new Discord.Client();

client.on('ready', () => {
  console.log(`I am ${client.user.tag}!`);
});

client.on('message', msg => {
  if (msg.content.includes('party time')) {
    msg.reply('☜(⌒▽⌒)☞');
  }
});

client.login(process.env.TOKEN);
```

### Running the Bot

Remember that token we needed to copy eariler? Now we get to use it. The token allows the bot code to know which bot account to use. In our code, we have our bot login with:

`client.login(process.env.TOKEN);`

This line means we have an environmemt variable set called TOKEN. Not sure what that means? Don't worry, you can simply run the following if you don't know how to export environment variables:

`TOKEN="YOUR TOKEN GOES HERE" node index.js`

There you have it. You have a running bot that replies to anyone who types `party time`.

Till next time, happy coding.
