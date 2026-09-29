<!-- LOVABLE:BEGIN -->
> [!IMPORTANT]
> This project is connected to [Lovable](https://lovable.dev). Avoid rewriting
> published git history — force pushing, or rebasing/amending/squashing commits
> that are already pushed — as it rewrites history on Lovable's side and the
> user will likely lose their project history.
>
> Commits you push to the connected branch sync back to Lovable and show up in
> the editor, so keep the branch in a working state.
<!-- LOVABLE:END -->

- Marketplace entities live in Lovable Cloud with owner-scoped access rules; this keeps projects, proposals, messages, and profiles consistent across pages.
- Public browsing and account-scoped actions share `src/lib/marketplace.ts` and reusable marketplace components; this avoids duplicated representations.
- The official uploaded logo is served through its immutable asset pointer and a proportionally resized favicon; never redraw or replace it.
