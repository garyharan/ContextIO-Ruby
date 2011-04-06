Context.IO Gem Source
=====================

This repository contains the source for the Context.IO gem.

If all you want is to use the gem can install it with the following command:

    gem install contextio

get more information at "http://context.io":http://context.io.  Complete 
API documentation is available at "http://developer.context.io":http://developer.context.io.

An example
----------

    require 'contextio'
    require 'json'

    key     = 'the key you get in your developer console'
    secret  = ' the secret you get in your developer console'
    account = 'your account name... probably just your email'

    connection = ContextIO::Connection.new(key, secret)
    messages = connection.all_messages(:account => account, :since => (Time.now - 24 * 60 * 60 * 5))
    puts JSON.parse(messages)['data'].first['subject']

LICENSE
-------

Copyright (C) 2011 DokDok Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

