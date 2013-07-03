#config simplify factor for each topojson

app/assets/data/compact.json:: raw/realprice20121112.json
	jq -c '[.[] | {address,caseNo,pos: [.pos[1], .pos[0]], price: .fields["交易總價(含車位)"], unitprice: .fields["交易單價(含車位)"] }] ' $< > $@

raw/realprice20121112.json: raw
	curl -Lo $@ https://www.dropbox.com/s/7u2h5h3aejaz7t5/realprice20121112.json?dl=1

raw:
	mkdir raw
