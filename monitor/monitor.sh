#!/bin/bash

if grep $KEYWORD $PATHLOG
then
echo "The keyword $KEYWORD exists!!!"
else
echo "No keyword!!!"
fi
