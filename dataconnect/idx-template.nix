/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs, sample ? "nextjs-email-app", projectId ? "FIREBASE_PROJECT_ID", ... }: {
  packages = [
    pkgs.nodejs_20
  ];

  bootstrap = ''
    mkdir "$out"
    mkdir "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix
    ${
      if sample == "nextjs-email-app" then "cp -r ${./nextjs-email-app}/* \"$out\""
      else "cp -r ${./nextjs-blank}/* \"$out\""
    }
    cp ${./.firebaserc} "$out"/.firebaserc
    cp ${./.graphqlrc.yaml} "$out"/.graphqlrc.yaml
    mkdir "$out"/.vscode
    cp ${./.vscode/settings.json} "$out"/.vscode/settings.json
    chmod -R u+w "$out"
    sed -i 's/FIREBASE_PROJECT_ID_HERE/${projectId}/g' "$out"/.firebaserc
    sed -i 's/FIREBASE_PROJECT_ID_HERE/${projectId}/g' "$out"/webapp/src/data-connect/index.tsx
  '';
}
