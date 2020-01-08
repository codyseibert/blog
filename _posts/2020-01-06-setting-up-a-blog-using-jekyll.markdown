---
layout: post
title: 'Making Your Own Jekyll Blog Hosted on GitHub Pages'
date: 2020-01-06 23:51:58 -0500
categories: jekyll tutorial
---

### Prerequisites

In order to follow this tutorial, you will need a github account already setup. It's really easy to do, so head over to [https://github.com](https://github.com) and create your account now.

You must have Ruby and Gem installed. I think those are all packaged when you install ruby, but you can easily double check by running the following in your terminal:

`ruby --version`
`gem --version`

If a verison number prints for those 2 commands, you are good to start.

### Setup a GitHub Repo

If you plan to either host Jekyll yourself or use an alternative version control, you can skip this section. Keep in mind that you can save a nickel and dime by hosting any of your static sites using GitHub pages.

You can create a new repository here: [https://github.com/new](https://github.com/new). We will need to clone this repo, so for this tutorial, let's assume we are going to use `~/Workspace`. Feel free to choose your favorite project directory. You can clone a repo by running the following command:

`cd ~/Workspace && git clone https://github.com/YOUR_ACCOUNT_NAME/YOUR_REPO_NAME.git`

At this point, you can navigate into your project using:

`cd ~/Workspace/YOUR_REPO_NAME`

### Installing Jekyll Gem

This entire setup is really easy, and this tutorial won't take much time. First, you'll need to install the Jekyll gem:

`gem install bundler jekyll`

You may need to use `sudo` in front of that command if you get permission errors. It is recommended to not use `sudo` to install gems, so if you need to do this, you may want to search around for what went wrong in your setup and use something such as `RVM`.

Awesome, now you should be able setup a project in Jekyll

### Setting up Jekyll Project

In a terminal, navigate into your cloned github repo if it is not already your current working directory:

`cd ~/Workspace/YOUR_REPO_NAME`

Now we can setup Jekyll inside that directory with a single command:

`jekyll new .`

This will create a couple of folders and files. I won't go into detail of all of them, but let's talk about the most important ones.

#### \_config.yml

This is the configuration file for your Jekyll blog. The theme your Jekyll blog uses will load this file to get certain hard coded values needed for the site to function. Feel free to edit some of the metadata fields to match what you want your blog to be titles and add some links to your twitter.

The **MOST IMPORTANT FIELD** you need to update is `url` and `baseUrl`. `url` will need to be set for your github pages url for your repo, which should be `https://YOUR_GITHUB_ACCCOUNT_NAME.github.io` and `baseUrl` needs to be your repo name like so: `/YOUR_REPO_NAME`. If you fail to set this up, your blog will not work correctly when deployed.

If you are interested in setting up google analytics, you can add a property called `google_analytics` and provide your google analytics ID, like so:

`google_analytics: UA-XXX-1`

### \_posts

The `_posts` directory is where you can put your daily blog posts. They need to following a particular structure which looks like so:

`YEAR-MONTH-DAY-YOUR_TITLE_HERE.markdown`

The date of your file will be the date it shows up in your blog. Inside the .markdown file itself, there is a header which includes some metadata about the file:

```
---
layout: post
title: 'Coding a Discord Bot'
date: 2020-01-05 23:51:58 -0500
categories: discord node.js javascript
---
```

Everything in this header is pretty self explanatory, except for `layout`. This is the magic part of Jekyll. Since we are using a installed theme called `minima`, all the code for the layouts are found in the github repo for minima here: (https://github.com/jekyll/minima)[https://github.com/jekyll/minima]. Check out the `_layouts` directory of that project and you can see they have 4 different layouts: `default.html`, `home.html`, `page.html`, `post.html`. This is that layout property's definition.

Jekyll themes could be an entire new blog post, so I'm going to stop before I create a message of this post.

### Running your Blog Locally

While you are working on your posts, you often want to run your blog locally so that you can preview your site. This can be accomplished in a single command:

`bundle exec jekyll serve`

Your site will be hosted at `http://localhost:4000`

One thing I want to note is this command will automatically refresh your blog posts as you edit them, but certain files, such as `_config.yml` will require a full restart of your local jekyll server to see changes.

### Deploying your Blog

Because we are using github and github pages, deploying this blog is super simple.

First, you need to change the Github Pages settings for your repo (https://github.com/codyseibert/blog/settings)[https://github.com/codyseibert/blog/settings]. Scroll down near the bottom until you find the `Github Pages` section. Change your branch to `master`. This makes things easier.

Second, you need to commit and push your code to the master branch. Now, if you are unfamiliar with how to use git and push code to github, you may want to read another blog post or watch some tutorials because that is important information.

Since that's out of scope for this tutorial, I'll give you the command you can use:

`git add --all && git commit -m 'my first jekyll commit' && git push origin master`

After your code has been pushed, give github pages a couple of seconds to build your jekyll site. After waiting, you can access your site here:

`https://YOUR_GITHUB_ACCOUNT_NAME.github.io/YOUR_REPO_NAME`

TADA!

Congrats, you hosted your first Jekyll blog on github pages! Be sure to read up on the documentation for Jekyll and the Minima theme so you can start customizing your pages and styles.

Until next time, happy coding!
