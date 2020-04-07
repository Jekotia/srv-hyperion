#! /bin/bash
# https://annvix.com/blog/using-letsencrypt-with-plex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

HOST="hyperion.jekotia.net"
ACMEHOME="${_ROOT}/acme"
CERTDIR=${ACMEHOME}/${HOST}
CERTPASS="foo"
DESTDIR="${_DATA}/acme-cert"
PKFXFILE="${_NAME}-plex-certificate.pkfx"

. "$ACMEHOME/acme.sh.env"

source ${_ROOT_CONFIG}/secrets.conf
export CF_Key="$CFDNS_SECRETS_AUTH_KEY"
export CF_Email="$CFDNS_SECRETS_AUTH_EMAIL"

cd $ACMEHOME

function getCert() {
	#--staging
	./acme.sh \
		--home ${ACMEHOME} \
		--issue \
		--dns dns_cf \
		-d $HOST

	return $?
}

function exportCert() {
	openssl pkcs12 -export \
		-out "${DESTDIR}/${PKFXFILE}" \
		-inkey "${CERTDIR}/${HOST}.key" \
		-in "${CERTDIR}/${HOST}.cer" \
		-certfile "${CERTDIR}/fullchain.cer" \
		-passout pass:${CERTPASS}

	return $?
}

case $1 in
	"--getcert")
		getCert
	;;
	"--exportcert")
		exportCert
	;;
	"--cron")
		TMPFILE=$(mktemp)
		md5sum ${CERTDIR}/${HOST}.cer >${TMPFILE}
		case $2 in
			"--force")
				${ACMEHOME}/acme.sh --cron --home ${ACMEHOME} --force
			;;
			*)
				${ACMEHOME}/acme.sh --cron --home ${ACMEHOME}
			;;
		esac

		md5sum -c ${TMPFILE}
		if [ "$?" == "0" ]; then
			# nothing has changed
			rm -f ${TMPFILE}
			exit 0
		fi

		echo "Exporting key for Plex"
		openssl pkcs12 -export -out ${DESTDIR}/${PKFXFILE} \
			-inkey ${CERTDIR}/${HOST}.key \
			-in ${CERTDIR}/${HOST}.cer \
			-certfile ${CERTDIR}/fullchain.cer \
			-passout pass:${CERTPASS}

		chmod 644 ${DESTDIR}/${PKFXFILE}
		rm -f ${TMPFILE}
	;;
	*)
		echo "Usage:"
		echo "--getcert"
		echo "--exportcert"
		echo "--cron"
		echo "    --force"
	;;
esac