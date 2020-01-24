#!/usr/bin/env bash
set -ue
DEFAULT_CHANNEL=#general
DEFAULT_USERNAME=bot
DEFAULT_ICON_EMOJI=:robot_face:
SLACK_WEBHOOK_URL=XXXXX

while getopts c:i:u: OPT
do
    case $OPT in
        c)  CHANNEL=$OPTARG
            ;;
        i)  ICON=$OPTARG
            ;;
        u)  USERNAME=$OPTARG
            ;;
    esac
done
shift $((OPTIND - 1))


data=$(cat <<JSON
{
  "channel": "${CHANNEL:-${DEFAULT_CHANNEL}}",
  "username": "${USERNAME:-${DEFAULT_USERNAME}}",
  "text": "$@",
  "icon_emoji": "${ICON:-${DEFAULT_ICON_EMOJI}}"
}
JSON
)

curl \
  -X POST \
  -H 'Content-type: application/json' \
  --data "$data" \
  "$SLACK_WEBHOOK_URL"

